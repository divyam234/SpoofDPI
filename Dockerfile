FROM alpine as builder

RUN apk add --no-cache ca-certificates tar xz bash curl unzip && update-ca-certificates

WORKDIR /app

RUN curl -s https://sh-install.vercel.app/divyam234/SpoofDPI | bash

FROM scratch

COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/

COPY --from=builder  /app/spoof-dpi /spoof-dpi

ENTRYPOINT ["/spoof-dpi","-addr","0.0.0.0"]