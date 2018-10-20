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

/var/www/html/index.html:
  file:
    - managed
    - source: salt://webserver/index.html
    - require:
      {% if grains['os'] == 'RedHat' or grains['os'] == 'CentOS' %}
      - pkg: httpd
      {% elif grains['os'] == 'Ubuntu' %}
      - pkg: apache2
      {% endif %}
