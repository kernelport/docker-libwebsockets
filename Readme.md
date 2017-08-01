# Docker image with libwebsockets lwsws server based on debian stretch

## Build
docker build -t libwebsockets .

## Run
docker run -p 80:7681 -it libwebsockets

## Use the automated Build
docker pull kernelport/docker-libwebsockets

## Demo App
open web browser:
http://localhost:80

### check URL for eg. HA Proxy
http://localhost:80/check/check.html

## Problems
### Disconnect the websocket connection after 4418-4424 ticks in the dumb increment-protocol
lwsws[7]: mirror 
lwsws[7]: Created new mi 0x556942153c90 ''
lwsws[7]: wsi 0x5569421483a0: TIMEDOUT WAITING on 25 (did hdr 0, ah 0x55694210d1a0, wl 0, pfd events 1) 1501604339 vs 1501604338
lwsws[7]: lws_header_table_detach: wsi 0x5569421483a0: ah held 11s, ah.rxpos -1, ah.rxlen -1, mode/state 0 4,wsi->more_rx_waiting 0
lwsws[7]: wsi 0x556942152e40: TIMEDOUT WAITING on 17 (did hdr 0, ah (nil), wl 0, pfd events 0) 1501604550 vs 1501604549
lwsws[7]: wsi 0x5569421538a0: TIMEDOUT WAITING on 17 (did hdr 0, ah (nil), wl 0, pfd events 0) 1501604550 vs 1501604549
lwsws[7]: wsi 0x556942153200: TIMEDOUT WAITING on 17 (did hdr 0, ah (nil), wl 0, pfd events 0) 1501604550 vs 1501604549
lwsws[7]: bad lws_meta cmd 0x72

#### libwebsockets-test-server result to 
docker run -p 80:7681 -it libwebsockets /usr/local/bin/libwebsockets-test-server

running without Disconnect


### OPTIONS results in 404 Not Found 
```
# curl -i -X OPTIONS http://localhost:80/check/check.html
HTTP/1.1 404 Not Found
server: lwsws
content-type: text/html
content-length: 38

<html><body><h1>404</h1></body></html>
```

```
# curl -i -X OPTIONS http://localhost:80/
HTTP/1.1 404 Not Found
server: lwsws
content-type: text/html
content-length: 38

<html><body><h1>404</h1></body></html>
```

#### libwebsockets-test-server result to 
sudo docker run -p 80:7681 -it libwebsockets /usr/local/bin/libwebsockets-test-server

show the test.html content
