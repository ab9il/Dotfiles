#!/bin/sh
case "$(file -Lb --mime-type -- "$1")" in
image/*)
    chafa -f sixel -s "${2}x${3}" "$1" 2>/dev/null || chafa "$1" -s "${2}x${3}"
    ;;
application/vnd.oasis.opendocument.text)
    odt2txt "$1" 2>/dev/null || pandoc -t plain "$1" 2>/dev/null
    ;;
application/pdf)
    pdftotext "$1" -
    ;;
text/* | application/json)
    bat --color=always --style=plain "$1" 2>/dev/null || cat "$1"
    ;;
*)
    # Archive and other file previews
    case "$1" in
    *.tar*) tar tf "$1" ;;
    *.zip) unzip -l "$1" ;;
    *.rar) unrar l "$1" ;;
    *.7z) 7z l "$1" ;;
    *) echo "lesspipe not installed or could not open file" ;;
    esac
    ;;
esac
