# vnc_capture
Dockerized VNC capture using vnc2flv

## Usage
Great for use with selenium/standalone-chrome-debug

```yaml
version: '2'

services:
  chrome:
    image: selenium/standalone-chrome-debug

  vnc_capture:
    image: brahaney/vnc_capture
    command: "chrome 5900"
    volumes:
      - ./data/:/data
    depends_on:
      - chrome
```

