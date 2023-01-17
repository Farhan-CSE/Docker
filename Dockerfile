FROM ubuntu:18.04
RUN apt-get update && apt-get install -y postgresql-client python3-pip python-dev python3-dev libxml2-dev libxslt1-dev zlib1g-dev libsasl2-dev libldap2-dev build-essential libssl-dev libffi-dev libmysqlclient-dev libjpeg-dev libpq-dev libjpeg8-dev liblcms2-dev libblas-dev libatlas-base-dev
RUN useradd -m odoo
RUN mkdir /opt/odoo
RUN wget -O odoo.tar.gz https://github.com/odoo/odoo/archive/13.0.tar.gz
RUN tar -xvf odoo.tar.gz -C /opt/odoo --strip-components=1
RUN pip3 install -r /opt/odoo/requirements.txt
COPY odoo.conf /etc/odoo/
RUN chown odoo:odoo /etc/odoo/odoo.conf
EXPOSE 8069 8072
USER odoo
CMD ["/usr/bin/python3","/opt/odoo/odoo-bin","--config=/etc/odoo/odoo.conf"]
docker build -t odoo-13 
