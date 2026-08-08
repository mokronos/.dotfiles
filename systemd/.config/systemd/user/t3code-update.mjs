#!/usr/bin/env node

import { execFile } from "node:child_process";
import { mkdtemp, readFile, rename, rm, writeFile } from "node:fs/promises";
import { dirname, join } from "node:path";
import { promisify } from "node:util";

const run = promisify(execFile);
const baseDir = process.env.T3CODE_HOME;

if (!baseDir) throw new Error("T3CODE_HOME is required.");

const runtimeDir = join(baseDir, "runtime");
const versionsDir = join(runtimeDir, "versions");
const statePath = join(runtimeDir, "service-state.json");
const npm = join(dirname(process.execPath), "npm");
const { stdout } = await run(npm, ["view", "t3@nightly", "version", "--json"], {
  timeout: 30_000,
});
const targetVersion = JSON.parse(stdout);

if (typeof targetVersion !== "string" || !/^\d+\.\d+\.\d+(?:-[0-9A-Za-z.-]+)?(?:\+[0-9A-Za-z.-]+)?$/.test(targetVersion)) {
  throw new Error("npm returned an invalid T3 Code nightly version.");
}

const targetDir = join(versionsDir, targetVersion);
const entryPath = join(targetDir, "node_modules", "t3", "dist", "bin.mjs");
const sentinelPath = join(targetDir, ".install-complete");
let installed = false;

try {
  installed = (await readFile(sentinelPath, "utf8")).trim() === targetVersion;
  if (installed) await readFile(entryPath);
} catch {
  installed = false;
}

if (!installed) {
  await rm(targetDir, { recursive: true, force: true });
  const stagingDir = await mkdtemp(join(versionsDir, ".staging-"));
  try {
    await run(npm, ["install", "--prefix", stagingDir, "--no-fund", "--no-audit", `t3@${targetVersion}`], {
      timeout: 600_000,
    });
    await readFile(join(stagingDir, "node_modules", "t3", "dist", "bin.mjs"));
    await writeFile(join(stagingDir, ".install-complete"), `${targetVersion}\n`, { mode: 0o600 });
    await rename(stagingDir, targetDir);
  } catch (error) {
    await rm(stagingDir, { recursive: true, force: true });
    throw error;
  }
}

const state = JSON.parse(await readFile(statePath, "utf8"));
await writeFile(statePath, `${JSON.stringify({ ...state, activeVersion: targetVersion }, null, 2)}\n`, { mode: 0o600 });
