#!/bin/bash

# === ASCII Banner ===
clear
cat << 'EOF'
======================================================
 ___           _             _   _             _            
|_ _|_ __   __| | _____  __ | | | |_   _ _ __ | |_ ___ _ __ 
 | || '_ \ / _` |/ _ \ \/ / | |_| | | | | '_ \| __/ _ \ '__|
 | || | | | (_| |  __/>  <  |  _  | |_| | | | | ||  __/ |   
|___|_| |_|\__,_|\___/_/\_\ |_| |_|\__,_|_| |_|\__\___|_|       
      
        Google Dork generator – Index Hunter     
======================================================
        By: KaliyugH4cker-Ashwatthama  
EOF
function open_in_browser() {
    url="$1"
    if [[ -z "$url" ]]; then
        return
    fi

    # Detect platform and open browser accordingly
    if command -v xdg-open > /dev/null; then
        xdg-open "$url"
    elif command -v open > /dev/null; then
        open "$url"  # macOS
    elif command -v powershell.exe > /dev/null; then
        powershell.exe start "$url"
    else
        echo "Cannot open browser: $url"
    fi

    sleep 1.5
}

function generate_dorks() {
    local domain="$1"
    local company="$2"

    echo ""
    echo "--- GitHub Dorks ---"
    github_dorks=(
        "site:github.com \"$domain\""
        "site:github.com \"$domain\" password"
        "site:github.com \"$domain\" secret"
        "site:github.com \"$domain\" api_key"
        "site:github.com \"$domain\" AWS_ACCESS_KEY"
        "site:github.com \"$domain\" DB_PASSWORD"
        "site:github.com \"$domain\" filename:.env"
        "site:github.com \"$domain\" filename:config.json"
        "site:github.com \"$domain\" filename:.aws/credentials"
        "site:github.com \"$domain\" filename:id_rsa"
        "site:github.com \"$domain\" filename:.npmrc"
        "site:github.com \"$domain\" filename:.bash_history"
        "site:github.com \"$domain\" filename:.git/config"
        "site:github.com \"$domain\" filename:.htpasswd"
        "site:github.com \"$domain\" filename:.docker/config.json"
        "site:github.com \"$domain\" filename:credentials"
        "site:github.com \"$domain\" filename:secrets.js"
        "site:github.com \"$domain\" filename:config.js"
        "site:github.com \"$domain\" filename:*.js secret"
        "site:github.com \"$domain\""
        "site:gitlab.com \"$domain\""
        "site:bitbucket.org \"$domain\""
   )
    for dork in "${github_dorks[@]}"; do
        echo "- $dork"
        open_in_browser "https://www.google.com/search?q=$dork"
    done

    echo ""
    echo "--- Google Dorks ---"
    google_dorks=(
        "site:$domain inurl:admin"
        "site:$domain intitle:\"index of\""
        "site:$domain ext:sql OR ext:xml OR ext:conf OR ext:log OR ext:old OR ext:backup"
        "site:$domain inurl:login"
        "site:$domain \"password\" filetype:xls OR filetype:csv"
        "site:$domain filetype:env OR filetype:json OR filetype:log OR filetype:ini"
        "site:$domain filetype:js \"apiKey\" OR \"token\" OR \"secret\""
        "site:$domain ext:js"
        "site:$domain ext:git OR inurl:.git"
        "\"$domain\" AND \"confidential\""
        "\"$domain\" AND \"internal use only\""
        "site:$domain inurl:\"wp-config.php\""
        "site:$domain inurl:\"config.php\""
        "site:$domain inurl:\"database.yml\""
        "site:$domain \"Authorization: Basic\""
        "site:$domain \"Bearer \""
        "site:$domain intitle:\"Dashboard\" OR intitle:\"Admin Panel\""
        "site:$domain inurl:login"
        "site:$domain intitle:Login"
        "site:$domain inurl:admin"
        "site:$domain inurl:administrator"
        "site:$domain inurl:auth"
        "site:$domain inurl:cpanel"
        "site:$domain intitle:'Dashboard'"
        "site:$domain inurl:signin"
        "site:$domain filetype:pdf"
        "site:$domain filetype:xls"
        "site:$domain filetype:xlsx"
        "site:$domain filetype:doc"
        "site:$domain filetype:docx"
        "site:$domain filetype:ppt"
        "site:$domain filetype:pptx"
        "site:$domain filetype:csv"
        "site:$domain filetype:txt"
        "site:$domain filetype:log"
        "site:$domain filetype:env"
        "site:$domain ext:sql"
        "site:$domain ext:json"
        "site:drive.google.com \"$domain\""
        "site:docs.google.com \"$domain\""
        "site:dropbox.com inurl:$domain"
        "site:mega.nz inurl:$domain"
        "site:s3.amazonaws.com inurl:$domain"
        "site:$domain ext:bak"
        "site:$domain ext:old"
        "site:$domain ext:swp"
        "site:$domain ext:git"
        "site:$domain ext:svn"
        "site:$domain ext:env"
        "site:$domain ext:conf"
        "site:$domain inurl:config"
        "site:$domain inurl:db"
    )
    for dork in "${google_dorks[@]}"; do
        echo "- $dork"
        open_in_browser "https://www.google.com/search?q=$dork"
    done

    echo ""
    echo "--- Shodan Queries ---"
    shodan_dorks=(
        "hostname:\"$domain\""
        "ssl.cert.subject.CN:\"$domain\""
        "http.title:\"$domain\""
        "ssl:\"$domain\""
    )
    if [[ -n "$company" ]]; then
        shodan_dorks+=("org:\"$company\"")
    fi
    for dork in "${shodan_dorks[@]}"; do
        echo "- $dork"
        open_in_browser "https://www.shodan.io/search?query=$dork"
    done

    echo ""
    echo "--- Other OSINT Tools ---"
    other_osint=(
        "https://censys.io/domain?q=$domain"
        "https://www.zoomeye.org/searchResult?q=$domain"
        "https://www.binaryedge.io/search?query=$domain"
        "https://hunter.io/search/$domain"
        "https://crt.sh/?q=%25.$domain"
        "https://publicwww.com/websites/%22$domain%22/"
        "https://dnsdumpster.com/"
    )
    for url in "${other_osint[@]}"; do
        echo "- $url"
        open_in_browser "$url"
    done
}

# Main CLI execution print_banner
echo ""
read -p "Enter target domain (e.g., example.com): " domain
read -p "Optional: Enter company name (for Shodan): " company

echo ""
echo "🚀 Launching dork queries in browser..."
generate_dorks "$domain" "$company"
echo ""
echo "✅ Done! All tabs opened."
