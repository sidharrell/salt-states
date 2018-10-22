site_source_code:
  file.managed:
    - name: /var/www/html/index.html
    - source: salt://webserver/index.html

minion_configuration_file:
  file.managed:
    - name: /etc/salt/grains
    - source: salt://webserver/grains

{% if grains['os'] == 'RedHat' or grains['os'] == 'CentOS' %}
{% set service_name = 'httpd' %}
{% elif grains['os'] == 'Ubuntu' %}
{% set service_name = 'apache2' %}
{% endif %}

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
      - file: site_source_code

