FROM webdevops/apache-dev
RUN wget -O "/usr/local/bin/go-replace" "https://github.com/webdevops/goreplace/releases/download/1.1.2/gr-arm64-linux" \
 && chmod +x "/usr/local/bin/go-replace" \ 
 && "/usr/local/bin/go-replace" --version

RUN a2enmod http2