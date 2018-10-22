base:
  'saltmaster.vhwebdev.com':
    - loadbalancer
  'minion*':
    - webserver
