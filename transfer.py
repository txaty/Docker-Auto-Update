import pysftp
import sys
USER = ''
HOST = ''
PASSWORD = ''
BACKUP_PATH = '/root/DockerVolumeBackups'

def initialization():
    sftp = pysftp.Connection(host=HOST, username=USER, password=PASSWORD)
    if not sftp.exists(BACKUP_PATH):
        sftp.mkdir(BACKUP_PATH)
        print('Created directory: ' + BACKUP_PATH + ' on ' + HOST)
        sftp.close()


def transfer_files():
    local_path = sys.argv[2] + '/backups'
    sftp = pysftp.Connection(host=HOST, username=USER, password=PASSWORD)
    sftp.put_d(local_path, BACKUP_PATH, preserve_mtime=True)
    
    
if __name__ == '__main__':
    choice = sys.argv[1]
    if choice == 'i':
        initialization()
        print('Done')
    elif choice == 't':
        initialization()
        transfer_files()
        
