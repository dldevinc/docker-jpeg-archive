# docker-jpeg-archive
Docker image with compiled danielgtaylor/jpeg-archive binaries

## Usage example

```shell
docker run --user 1000:1000 --rm -v $(pwd):/img bugoman/jpeg_archive jpeg-recompress --quiet --strip --quality medium --method smallfry /img/input.jpg /img/output.jpg
```
