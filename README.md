# DarkerNZBget
[![Discord](https://img.shields.io/badge/Chat-Discord-738bd7.svg?style=for-the-badge)](https://discord.gg/fKcCXwb)<br>
Custom CSS to apply to NZBget using an NGINX subfilter

Using a NGINX sub filter is the only way to apply this specific branch of the repo to NZBget. Below, is one example, of how to use a reverse proxy block in NGINX to apply. If you're looking for a different/better way, go to the [Develop](https://github.com/ydkmlt84/DarkerNZBget/tree/develop) branch and read the README over there.
```
#NZBGet ReverseProxy
        location /nzbget {
                proxy_pass http://localhost:<NZBgetPORT>;
                proxy_set_header Host $host;
                proxy_set_header X-Real-IP $remote_addr;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_set_header Accept-Encoding "";
                sub_filter '</head>' '<link rel="stylesheet" type="text/css" href="https://rawgit.com/ydkmlt84/DarkerNZBget/master/nzbget_custom_darkblue.css"></head>';
                sub_filter_once on;
        }

```
<br>
<i>Rawgit link for master branch = https://rawgit.com/ydkmlt84/DarkerNZBget/master/nzbget_custom_darkblue.css</i></br>
<br>
<b> Screenshots</b>
</br>
<img src="https://i.imgur.com/rxXM2Wy.png"></img>
<br>
<img src="https://i.imgur.com/c4qNczJ.png"></img>
