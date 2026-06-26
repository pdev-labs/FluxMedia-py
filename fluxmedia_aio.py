#!/usr/bin/env python3
"""
FluxMedia CLI Stub
For backwards compatibility with direct execution of fluxmedia_aio.py
"""

import sys

try:
    from fluxmedia.main import main
except ImportError:
    # If not installed as a package, add package parent directory to path to allow direct local execution
    import os
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
    from fluxmedia.main import main

if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        print("\nExiting...")
        sys.exit(0)
