base:
  'saltmaster.vhwebdev.com':
    - loadbalancer/loadbalancer
  'minion*':
    - webserver/webserver
