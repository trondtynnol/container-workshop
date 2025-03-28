# Container-workshop
Likt oppsett overalt, så ein slepp problemet "Det funkar på mi maskin". Lettare enn virtuelle maskiner.

Docker, Podman: 99,9 % kompatible, skal kunna køyre `alias docker=podman`

Test installasjonen: `podman run docker.io/library/hello-world`

Køyre Ubuntu: `podman run docker.io/library/ubuntu:latest`
Interaktivt: `-it`
`Ctrl+D` for å lukke.
Vanleg praksis er å køyre med `--rm` for å fjerne containerar når dei er ferdige med å køyre, men i blant vil ein ikkje gjera det for å sleppe å laste ned alt av avhengigheiter på nytt kvar gong. For å sjå alle aktive containerar, `podman ps -a`. For å fjerne alle inaktive, `podman container prune`.
Restarte sist køyrde container: `podman start --latest -i --attach`

## Nginx
Nginx i container: vil gjerne gje imaget tilgang på ein stig i filsystemet: `-v stig/lokalt:stig/i/imaget`
Legg html-fil i noverande mappe.
`podman run -it --rm -p 4000:80 -v $(pwd):/usr/share/nginx/html docker.io/library/nginx`
`localhost:4000`
Leggje i bakgrunnen: `Ctrl+P+Q`. Reopne: `podman attach <namn>` (namn finn ein frå `podman ps`)


## Pandoc
```
cd ~/gt/github/giellalt/lang-sme/
podman run --rm -v "$(pwd):/data" mirror.gcr.io/pandoc/core:latest README.md -o README.html
```

## Containerfile:
Containerfile/Dockerfile

Lag ei fil som heiter Containerfile med innhald som t.d.
```
FROM docker.io/library/ubuntu:latest
RUN apt update && apt install --no-install-recommends -y vim
WORKDIR /outside
CMD [ "/usr/bin/vim" ]
```
FROM: kva image
RUN: kva ein skal gjera i imaget
WORKDIR: stigen ein startar på
CMD: standardkommando som skal køyrast om ikkje noko anna er spesifisert

Deretter: `podman build -t vim -f Containerfile`
`-t`: tag, dvs namn
Dette lagar eit image, som er deretter kan køyre: `podman run --rm -it -v $(pwd):/outside vim`
