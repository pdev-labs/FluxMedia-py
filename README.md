# 🌊 FluxMedia

FluxMedia is a powerful, open-source, and cross-platform command-line media downloader designed for simplicity, robustness, and speed. Built on top of `yt-dlp` and `rich`, it provides a beautiful terminal user interface (TUI) to download videos, audio streams, playlists, channel uploads, and subtitles from thousands of supported websites.

---

## 🚀 Quick Start

### 1. Installation
Install FluxMedia globally on any system running Python 3.10+ directly via `pip`:
```bash
pip install fluxmedia
```

### 2. Execution
Run the interface from any terminal or command prompt:
```bash
fluxmedia
```

---

## ✨ Key Features

* **Dynamic Console TUI**: Renders rich tables, panels, and live progress bars for download speeds, ETA, and file sizes.
* **Smart Audio Extraction**: Automatically extract and convert media into high-quality MP3 (192kbps) with embedded cover art and metadata (requires FFmpeg).
* **Metadata & Cover Art Embedding**: Automatically write video thumbnails and details (description, uploader, dates) directly into your downloads.
* **Batch Downloads**: Save entire playlists or recent uploads from content creator channels.
* **Subtitles Capturing**: Download caption files directly for specified language codes.
* **Global Settings**: Customize download folders, default formats, filename structures, and UI themes inside the app.

---

## 🛠️ Requirements & Setup

* **Python**: Version 3.10 or higher.
* **FFmpeg (Highly Recommended)**: Required for merging high-definition video formats and converting audio to MP3.
  * **Windows**: `winget install Gyan.FFmpeg`
  * **macOS**: `brew install ffmpeg`
  * **Linux**: `sudo apt install ffmpeg`

---

## 👑 Credits & Support
This project was created and is fully maintained by **Priyanshu Chauhan** ([@pdev-labs](https://github.com/pdev-labs)).
I am a student in India (Standard 11, PCM with CS) and I spent a couple of weeks designing, coding, and perfecting FluxMedia alone. 

If you find this tool helpful, please support my work by giving it a star on GitHub! ⭐
* **GitHub Repository**: [https://github.com/pdev-labs/FluxMedia-py](https://github.com/pdev-labs/FluxMedia-py)
* **GitHub Profile**: [https://github.com/pdev-labs](https://github.com/pdev-labs)
* **Support via UPI**: `priyanshuc@fam`

---

## 🐛 Bugs, Errors & Feedback
Got an issue, bug, or feature request? I would love to hear from you! Please file reports directly at:
👉 **[FluxMedia Issue Tracker](https://github.com/pdev-labs/FluxMedia-py/issues)**

To help me resolve errors quickly, please:
1. Search active issues first to avoid duplicate bug tickets.
2. Provide details about your Operating System and whether FFmpeg is installed.
3. Paste logs or stderr dumps. (Local execution logs are saved inside your home directory under `~/.fluxmedia/fluxmedia.log`).
