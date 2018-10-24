haproxy_configuration:
  file.managed:
    - name: /etc/haproxy/haproxy.cfg
    - source: salt://loadbalancer/haproxy.cfg
    - template: jinja
    - makedirs: True
haproxy_ssl_cert:
  file.managed:
    - name: /etc/pki/tls/certs/haproxy/selfsigned.pem
    - source: salt://loadbalancer/selfsigned.pem
    - makedirs: True

{% set service_name = 'haproxy' %}

haproxy:
  pkg.installed:
    - name: {{ service_name }}
  service.running:
    - name: {{ service_name }}
    - enable: True
    - require:
      - pkg: {{ service_name }}
  module.run:
    - name: service.reload
    - m_name: {{ service_name }}
    - onchanges:
      - file: haproxy_configuration

keepalived_configuration:
  file.managed:
    - name: /etc/keepalived/keepalived.conf
    - source: salt://loadbalancer/keepalived.conf
    - template: jinja
    - makedirs: True

keepalived_check_script:
  file.managed:
    - name: /etc/keepalived/check_haproxy.sh
    - source: salt://loadbalancer/check_haproxy.sh
    - mode: 755
    - makedirs: True

keepalived:
  pkg.installed:
    - name: keepalived
  service.running:
    - name: keepalived
    - enable: True
    - require:
      - pkg: keepalived
  module.run:
    - name: service.reload
    - m_name: keepalived
    - onchanges:
      - file: keepalived_configuration
    
{% if grains['os'] == 'RedHat' or grains['os'] == 'CentOS' %}
{% set service_name = 'httpd' %}
{% elif grains['os'] == 'Ubuntu' %}
{% set service_name = 'apache2' %}
{% endif %}

apache:
  pkg.removed:
    - name: {{ service_name }}

minion_configuration_file:
  file.managed:
    - name: /etc/salt/grains
    - source: salt://loadbalancer/grains

minion:
  module.run:
    - name: service.restart
    - m_name: salt-minion
    - onchanges:
      - file: minion_configuration_file
