site_source_code:
  file.managed:
    - name: /var/www/html/index.html
    - source: salt://webserver/index.html

apache:
  pkg.installed:
    {% if grains['os'] == 'RedHat' or grains['os'] == 'CentOS' %}
    - name: httpd
    {% elif grains['os'] == 'Ubuntu' %}
    - name: apache2
    {% endif %}
  service.running:
    {% if grains['os'] == 'RedHat' or grains['os'] == 'CentOS' %}
    - name: httpd
    - require:
      - pkg: httpd
    {% elif grains['os'] == 'Ubuntu' %}
    - name: apache2
    - require:
      - pkg: apache2
    {% endif %}
  module.run:
    - name: service.reload
    {% if grains['os'] == 'RedHat' or grains['os'] == 'CentOS' %}
    - m_name: httpd
    {% elif grains['os'] == 'Ubuntu' %}
    - m_name: apache2
    {% endif %}
    - onchanges:
      - file: site_source_code
