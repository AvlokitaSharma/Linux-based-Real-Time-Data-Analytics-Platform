sudo -u postgres createuser myuser -P  # Follow prompts to set the password
sudo -u postgres createdb analytics -O myuser



virtualenv myenv
source myenv/bin/activate
pip install psycopg2-binary flask pandas numpy


sudo systemctl start postgresql
sudo systemctl enable postgresql
sudo -u postgres psql



psql -U myuser -d mydatabase -c "INSERT INTO sensor_data (sensor_value) VALUES (25.7);"


psql -U myuser -d mydatabase -c "SELECT * FROM sensor_data;"


psql -U myuser -d mydatabase -c "UPDATE sensor_data SET sensor_value = 26.3 WHERE id = 1;"


psql -U myuser -d mydatabase -c "DELETE FROM sensor_data WHERE id = 1;"

sudo systemctl status postgresql
sudo systemctl restart postgresql
sudo journalctl -u postgresql


