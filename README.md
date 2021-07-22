# Unity Core
This repository contains shared tools and modules used for Unity development at Free Range Games.

## Contents
1. [Common Classes & Utilities](#common-classes--utilities)
2. [VR Classes & Utilities](#vr-classes--utilities)
3. [Localization](#localization)
4. [Networking](#networking)
5. [Debug Tools](#debug-tools)
6. [Build Tools](#build-tools)
7. [Performance & Optimizations](#performance--optimizations)
8. [Project Quality & Cleanup](#project-quality--cleanup)
9. [Contributing to Unity Core](#contributing-to-unity-core)

## Common Classes & Utilities
- [AssetFromScriptableObject](CoreBuild/Packages/AssetFromScriptableObject): Right-click on any ScriptableObject class in the Editor to create an asset for it.
- [CoreUtils](CoreBuild/Packages/CoreUtils): A series of util scripts shared between projects and modules.
- [FilesystemDatabase](CoreBuild/Packages/FilesystemDatabase): Very simple load and save to a file, where you define the root data type.
- [MonoMachine](CoreBuild/Packages/MonoMachine): Finite State Machine for Unity, based on MonoBehaviour.
- [RecyclingPool](CoreBuild/Packages/RecyclingPool): For pooling C# objects.
- [SimpleTextList](CoreBuild/Packages/SimpleTextList): TODO Need description, not listed in FRG Tools spreadsheet
- [Subtitles](CoreBuild/Packages/Subtitles): Displays text as subtitles, uses TextMeshPro, usable for cinematics or in-game dialogues.
- [TextureTint](CoreBuild/Packages/TextureTint): Takes a texture and creates a new one colored (baked tint) with selected color. Editor only.

## VR Classes & Utilities
- TODO

## Localization
- [ProjectText](CoreBuild/Packages/ProjectText): Scans project for all Text components and serialized strings in ScriptableObjects, makes a word count summary, offers localization and in-place text edit. Does not implement localization itself, just offers to mark strings for loc in preparation for it. Localization system is dependent on plugin used so it's its own system.
  - [ProjectText_I2Localization](CoreBuild/Packages/ProjectText_I2Localization): Extension/add-on to ProjectText that uses I2Localization plugin to localize and export strings to the plugin, making it ready to export/import into spreadsheet. Requires ProjectText module.

## Networking
- [LANDiscovery](CoreBuild/Packages/LANDiscovery): Pings and listens to create a list of all devices on same LAN.
- [NetworkSync](CoreBuild/Packages/NetworkSync): Networking solution for Unity based and depends on TCPClientServer module. Syncs positions, spawns prefabs, reparentings, custom network scripts etc.
- [OculusNetworking](CoreBuild/Packages/OculusNetworking): Wrapper for async Oculus Platform startup and Room creation.
- [TCPClientServer](CoreBuild/Packages/TCPClientServer): A simple TCP client and server for network messaging. Greg's implementation on the low end.

## Serialization
- [AutoGenSerialization](CoreBuild/Packages/AutoGenSerialization):	Autogenerates serialization types for data container classes and structs.
- [BinarySerialization](CoreBuild/Packages/BinarySerialization): Binary serialization for hand-rolled binary data types with minimal footprint.

## Debug Tools
- [DebugMenu](CoreBuild/Packages/DebugMenu): A canvas debug menu with a lot of options: performance, physics, rendering, ...
- [FPSCounter](CoreBuild/Packages/FPSCounter): Extremely fast fps counter with median values.
- [ScreenshotTool](CoreBuild/Packages/ScreenshotTool): Takes a screenshot from the main camera. Has alpha support.

## Build Tools
- [AndroidKeystoreSign](CoreBuild/Packages/AndroidKeystoreSign): Automatically resolves android keystore path and signs it on pre-build step with data provided in asset.
- [BuildManager](CoreBuild/Packages/BuildManager): Build Manager scripts for running custom build. Supports multiple apps within one project (multiple Products).
Jenkins config and CI python scripts not included yet, those must be copied from another project.
- [ShaderBuildReport](CoreBuild/Packages/ShaderBuildReport): Lists all shader variants included in the build, as a log in console on build time. Useful if you have your own shader stripping and need to see the results before and after.
- [ShaderStrip](CoreBuild/Packages/ShaderStrip): Scripts that strip unecessary shader variants in order to increase build speed. Quest and Focus only for now.

## Performance & Optimizations
- [AssetCulling](CoreBuild/Packages/AssetCulling): Goes through all meshes in the scenes and deletes verticies not visible from play area. Editor only.
- [ResourceChecker](CoreBuild/Packages/ResourceChecker): Editor tool that lists all the textures, meshes, materials in the scene and sorts them by size. Editor only.
- [UVClamping](CoreBuild/Packages/UVClamping): Fixes meshes with UVs above [0..1] range so they can be baked with other meshes. Editor only.

## Project Quality & Cleanup
- [ProjectTextureSettings](CoreBuild/Packages/ProjectTextureSettings): Goes through all the textures in the project and analyzes them, can mass change per defined usages. Editor only.
- [Unatlas](CoreBuild/Packages/Unatlas): Unatlases meshes with shared atlased texture. Used on Asset Store stuff. Editor only.
- [UnusedAssetTool](CoreBuild/Packages/UnusedAssetTool): Scans project for unused assets. Also finds and lists asset dependencies. Editor only.

## Contributing to Unity Core
All modules are individual Unity packages. They are embedded in the CoreBuild Unity project and then used in other projects as readonly packages.

Preparing a module for submission:
- Create a package for your module (details below).
- Commit your code to a branch with your module name.
- Wrap all your classes in the `FRG.Core` namespace or a subset that matches your module name.
- Add `<summary>` descriptions to all classes and public methods intended to be used by others.
- Make sure all dependencies are also located in unity-core or within your Module folder.
  - If the code is specific to a platform or Unity version, make sure it is wrapped in the appropriate `#ifdef`s and documented in your module's README.
  - If you do have a limitation on the Unity version, please specify this in the package.json as well.
- Add a one-line description to this README file in the appropriate section about the purpose of the tool.
  - Please maintain alphabetical order by tool/utility name.
- Lastly, create a pull request of your branch into `main` and get at least one person from another project to review and approve the merge.

Setting up your module's package:
1. Run CreateModulePackage.bat to create your module.
2. Move your code into the appropriate folders of the package (Editor/Runtime/Tests).
   - Delete unused folders and metas.
   - If you are only making an Editor tool, please make set your Platforms in the asmdef to Editor only (uncheck 'Any Platform', click 'Deselect all', check 'Editor').
3. In Unity (CoreBuild project), set your module's dependencies.
   - Add any dependencies to the asmdef so the package will compile.
   - Add dependencies on other Core packages to package.json (package names follow the com.frg.core.lowercasename format) so that they will be required in order to install the package in other projects.
4. Update package.json and README.md with the appropriate information for your module.

Documentation for README markup can be found [here](https://docs.github.com/en/github/writing-on-github/basic-writing-and-formatting-syntax).
