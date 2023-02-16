# nginx_htttps_proxy

```
  location / {
  access_by_lua_file /path/to/script.lua;
  proxy_pass http://localhost:8080;
}
```
