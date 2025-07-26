# Ansible Role: levonk.vibeops.multimedia

Installs a comprehensive suite of multimedia applications for command-line and graphical environments.

## Description

This role automates the installation of various tools for audio, video, and image processing. Installation is modular and controlled by boolean flags. Graphical applications will only be installed when the `graphical` tag is specified in the playbook run.

### Command-Line Tools

-   **CAVA**: Console-based audio visualizer.
-   **FFmpeg**: A complete, cross-platform solution to record, convert and stream audio and video.

### Graphical Tools

-   **Audacity**: A free, open-source, cross-platform audio software. (Note: OpenVINO plugins require separate, manual installation).
-   **CapCut**: A popular video editor.
-   **GIMP**: The GNU Image Manipulation Program, a free and open-source raster graphics editor.
-   **ImageMagick**: A software suite to create, edit, compose, or convert bitmap images.
-   **Kap**: An open-source screen recorder for macOS.
-   **OBS Studio**: Free and open source software for video recording and live streaming.
-   **paint.net**: Image and photo editing software for Windows.
-   **VLC**: A free and open-source, portable, cross-platform media player.

## Requirements

-   `winget` on Windows.
-   `homebrew` on macOS.
-   `apt` on Debian-based systems.

## Role Variables

Installation of each tool is controlled by a boolean variable in `defaults/main.yml`. By default, all are set to `false`.

- `multimedia_install_cava`: Installs CAVA.
- `multimedia_install_ffmpeg`: Installs FFmpeg.
- `multimedia_install_paint_dot_net`: Installs paint.net (Windows only).
- `multimedia_install_imagemagick`: Installs ImageMagick.
- `multimedia_install_capcut`: Installs CapCut.
- `multimedia_install_vlc`: Installs VLC.
- `multimedia_install_kap`: Installs Kap (macOS only).
- `multimedia_install_audacity`: Installs Audacity.
- `multimedia_install_obs_studio`: Installs OBS Studio.
- `multimedia_install_gimp`: Installs GIMP.

## Dependencies

None.

## Example Playbook

To install FFmpeg and VLC, define the variables in your playbook and run with the `graphical` tag:

```yaml
---
- hosts: workstations
  vars:
    multimedia_install_ffmpeg: true
    multimedia_install_vlc: true
  roles:
    - role: levonk.vibeops.multimedia
      tags: ["graphical"]
```

## License

Brillarc, LLC

## Author Information

This role was created by Cascade, an AI agent from Windsurf.
