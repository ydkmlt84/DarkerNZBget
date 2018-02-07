# DarkerNZBget
Custom CSS to apply to NZBget using an NGINX subfilter

As far as I know a NGINX sub filter is the only way to apply this custom CSS to NZBget.
```
#NZBGet RP
        location /nzbget {
                proxy_pass http://localhost:8006;
                proxy_set_header Host $host;
                proxy_set_header X-Real-IP $remote_addr;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_set_header Accept-Encoding "";
                sub_filter '</head>' '<link rel="stylesheet" type="text/css" hr$
                sub_filter_once on;
        }
```
