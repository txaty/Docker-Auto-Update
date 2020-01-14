import sys
import os
import datetime
import logging
from glob import glob


DATE_FORMAT = '%Y-%m-%d-%H:%M:%S'
backup_path = sys.argv[1] + '/backups/'
raw_file_name = glob(backup_path + '*.tar')
max_buffer_size = int(sys.argv[2])
logging.basicConfig(level=logging.DEBUG)

def find_earlist_date(date_list):
    if len(date_list) < 0:
        return
    earlist_date = datetime.datetime.strptime(date_list[0], DATE_FORMAT)
    for i in range(1, len(date_list)):
        iterate_date = datetime.datetime.strptime(date_list[i], DATE_FORMAT)
        if iterate_date < earlist_date:
            earlist_date = iterate_date
    result = earlist_date.strftime(DATE_FORMAT)
    return result
    

containers = {}
for i in range(3, len(sys.argv)):
    containers[sys.argv[i]] = list()
file_names = list()
for file_path in raw_file_name:
    file_name = os.path.basename(file_path)
    pure_name = os.path.splitext(file_name)[0]
    container_name = pure_name[20:]
    containers[container_name].append(pure_name[:19])

for key, date_list in containers.items():
    if len(date_list) < max_buffer_size:
        continue
    logging.info('Listing dates of the file for volumes of container: ' + key)
    for item in date_list:
        logging.info(item)
    while len(date_list) > max_buffer_size:
        try:
            earlist_date = find_earlist_date(date_list)
            logging.info('Find earlist date: ' + earlist_date)
            os.remove(backup_path + earlist_date + '-' + key + '.tar')
            date_list.remove(earlist_date)
            logging.info('Deleted earlist file.')
        except:
            logging.error('Error occurred! Does the user have the access to do that?')
            break
    logging.info('Listing dates of the file for volumes of container: ' + key)
    for item in date_list:
        logging.info(item)