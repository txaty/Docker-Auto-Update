import sys
import os
import datetime
from glob import glob

raw_file_name = glob(sys.argv[1] + '/backups/*.tar')
max_buffer_size = int(sys.argv[2])

containers = {}
for i in range(3, len(sys.argv)):
    containers[sys.argv[i]] = list()
file_names = list()
for file_path in raw_file_name:
    file_name = os.path.basename(file_path)
    pure_name = os.path.splitext(file_name)[0]
    container_name = pure_name[11:]
    print(container_name)
    containers[container_name].append(pure_name[:10])

print()
print(containers)