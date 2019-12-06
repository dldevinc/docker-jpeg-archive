# docker-jpeg-archive
Docker image with compiled danielgtaylor/jpeg-archive binaries

## Usage example

```shell
docker run --user 1000:1000 --rm -v $(pwd):/img bugoman/jpeg_archive /img/input.jpg --strip --quality medium --method smallfry /img/output.jpg
```

Process all JPEG files in parallel:
```shell
docker run --user 1000:1000 --rm -v $(pwd):/img bugoman/jpeg_archive /img --quiet --strip --quality medium --method smallfry
```
