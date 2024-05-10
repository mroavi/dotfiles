#!/usr/bin/env bash

# Source: https://www.reddit.com/r/commandline/comments/11tb26v/comment/jcjmzr9/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button

set -o noclobber -o noglob -o nounset -o pipefail
IFS=$'\n'

# Script arguments
FILE_PATH="${1}"		 # Full path of the highlighted file
let PV_WIDTH="${2} - 2"			 # Width of the preview pane (number of fitting characters)
PV_HEIGHT="${3}"		 # Height of the preview pane (number of fitting characters)
#IMAGE_CACHE_PATH="${4}"  # Full path that should be used to cache image preview
#PV_IMAGE_ENABLED="${5}"  # 'True' if image previews are enabled, 'False' otherwise.

FILE_EXTENSION="${FILE_PATH##*.}"
FILE_EXTENSION_LOWER=$(echo ${FILE_EXTENSION} | tr '[:upper:]' '[:lower:]')

# Settings
# HIGHLIGHT_SIZE_MAX=65536  # 256KiB
HIGHLIGHT_TABWIDTH=4
# HIGHLIGHT_STYLE='zmrok'
HIGHLIGHT_STYLE='solarized-light'
#PYGMENTIZE_STYLE='autumn'

handle_extension() {
  case "${FILE_EXTENSION_LOWER}" in
    # Archive
    a|ace|alz|apk|arc|arj|bz|bz2|cab|cpio|jar|lz|lzma|lzo|\
      rz|t7z|tlz|txz|tZ|tzo|war|xpi|xz|Z)
          7z -ba l -p -- "${FILE_PATH}" | cut -b 28-41,53-
          exit 0;;
        tar|tbz|tbz2|tgz)
          tar tvf "${FILE_PATH}" && exit 0
          exit 0;;
        lha|lzh)
          lha l "${FILE_PATH}" | cut -b 24-30,51- && exit 0
          exit 0;;
        # gz)
          # gunzip -l "${FILE_PATH}" | cut -b 28-40,47-
          # exit 0;;
        gz)
          zcat "${FILE_PATH}"
          exit 0;;
        zip)
          unzip -l "${FILE_PATH}" | cut -b 1-9,29- && exit 0
          exit 0;;
        rar)
          7z -ba l -- "${FILE_PATH}" | cut -b 28-41,53-
          exit 0;;
        7z)
          # Avoid password prompt by providing empty password
          7z -ba l -p -- "${FILE_PATH}" | cut -b 28-41,53-
          exit 0;;

    # pdf
    pdf)
    # Preview as text conversion
    pdftotext -l 5 -nopgbrk -layout -q -- "${FILE_PATH}" - && exit 0
    mediainfo "${FILE_PATH}" && exit 0
    exiftool "${FILE_PATH}" && exit 0
    exit 0;;

    # djvu
    djvu)
    exiftool "${FILE_PATH}" && exit 0
    exit 0;;

    # BitTorrent
    torrent)
    aria2c -S "${FILE_PATH}" && exit 0
    # transmission-show -- "${FILE_PATH}" && exit 0
    exit 0;;

    # OpenDocument
    #odt|ods|odp|sxw)
    #	 # Preview as text conversion
    #	 odt2txt "${FILE_PATH}" && exit 0
    #	 exit 0;;

    # Word-OOXML-Document
    docx)
    # Preview as text conversion
    docx2txt "${FILE_PATH}" - | fold -w "${PV_WIDTH}" && exit 0
    exit 0;;

    # HTML
    htm|html|xhtml)
    # Preview as text conversion
    w3m -dump "${FILE_PATH}" && exit 0
    lynx -dump -- "${FILE_PATH}" && exit 0
    elinks -dump "${FILE_PATH}" && exit 0
    exit 0;;

    # deb packages
    deb)
    dpkg --info "${FILE_PATH}" | fold -w "${PV_WIDTH}" && exit 0
    exit 0;;

    # disk images
    qcow2|raw|vdi|vmdk|vhd|vhdx)
    qemu-img info -U --backing-chain "${FILE_PATH}" && exit 0
    exit 0;;

    # Certificates
    pem|cer|crt)
    openssl x509 -text -noout -in "${FILE_PATH}"  | sed '/Modulus\:/,/Exponent\:/d' | sed '/Signature\ Value\:/,//d' | fold -w "${PV_WIDTH}" && exit 0
    exit 0;;

    # JSON
    json)
    jq -C '.' "${FILE_PATH}" && exit 0
    exit 0;;
esac
}


handle_mime() {
  local mimetype="${1}"
  case "${mimetype}" in
    # Text
    text/plain)
    # $PAGER -- "${FILE_PATH}"
    head -n ${PV_HEIGHT} "${FILE_PATH}"
    exit 0;;

  text/* | */xml)
    # Syntax highlight
    # if [[ "$( stat --printf='%s' -- "${FILE_PATH}" )" -gt "${HIGHLIGHT_SIZE_MAX}" ]]; then
    # exit 0
    # fi
    if [[ "$( tput colors )" -ge 256 ]]; then
      # local pygmentize_format='terminal256'
      local highlight_format='xterm256'
    else
      # local pygmentize_format='terminal'
      local highlight_format='ansi'
    fi
    highlight --replace-tabs="${HIGHLIGHT_TABWIDTH}" --out-format="${highlight_format}" \
      --style="${HIGHLIGHT_STYLE}" --force -- "${FILE_PATH}" && exit 0
          # pygmentize -f "${pygmentize_format}" -O "style=${PYGMENTIZE_STYLE}" -- "${FILE_PATH}" && exit 5
          exit 0;;

    # Image
    image/*)
    # Preview as text conversion
    # img2txt --gamma=0.6 --width="${PV_WIDTH}" -- "${FILE_PATH}" && exit 4
    chafa -s ${PV_WIDTH}x{PV_HEIGHT} -c full "${FILE_PATH}" && exit 0
    #chafa -c full "${FILE_PATH}" && exit 0
    #chafa -c 240 "${FILE_PATH}" && exit 0
    #chafa -s ${PV_WIDTH}x{PV_HEIGHT} -f sixel "${FILE_PATH}" | sed 's/#/\n#/g' && exit 0
    mediainfo "${FILE_PATH}" && exit 0
    exiftool "${FILE_PATH}" && exit 0
    exit 0;;

    # Video and audio
    video/* | audio/*)
    mediainfo "${FILE_PATH}" && exit 0
    exiftool "${FILE_PATH}" && exit 0
    exit 0;;
esac
}

handle_fallback() {
  printf "=====================\n==  file type  ==\n=====================\n\n" && file --dereference --brief -n -- "${FILE_PATH}" | sed 's/,\ /\n/g' | fold -w "${PV_WIDTH}"
  exit 0
}

# MIMETYPE="$( mimetype --brief --dereference -- "${FILE_PATH}" )"
MIMETYPE="$( file --dereference --brief --mime-type -- "${FILE_PATH}" )"

#if [[ "${PV_IMAGE_ENABLED}" == 'True' ]]; then
#	handle_image "${MIMETYPE}"
#fi
handle_extension
handle_mime "${MIMETYPE}"
handle_fallback

exit 0
