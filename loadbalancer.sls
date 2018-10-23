haproxy_configuration:
  file.managed:
    - name: /etc/haproxy/haproxy.cfg
    - source: salt://loadbalancer/haproxy.cfg
haproxy_ssl_cert:
  file.managed:
    - name: /etc/pki/tls/certs/haproxy/selfsigned.pem
    - source: salt://loadbalancer/selfsigned.pem

{% set service_name = 'haproxy' %}

apache:
  pkg.installed:
    - name: {{ service_name }}
  service.running:
    - name: {{ service_name }}
    - require:
      - pkg: {{ service_name }}
  module.run:
    - name: service.reload
    - m_name: {{ service_name }}
    - onchanges:
      - file: haproxy_configuration