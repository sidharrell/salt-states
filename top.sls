base:
  {% for loadbalancer in pillar['loadbalancers'] %}
  '{{ loadbalancer }}':
    - loadbalancer/loadbalancer
  {% endfor %}
  {% for webserver in pillar['webservers'] %}
  '{{ webserver }}':
    - webserver/webserver
  {% endfor %}
