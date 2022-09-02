echo '安装分布式文件存储库'
docker image pull delron/fastdfs
docker run -dit --name tracker --network=host -v  ~/projects/meiduo_project/fdfs/tracker:/var/fdfs delron/fastdfs tracker
docker run -dti --name storage --network=host -e TRACKER_SERVER=0.0.0.0:22122 -v  ~/projects/meiduo_project/fdfs/storage:/var/fdfs delron/fastdfs storage
echo '导入文件'
rm -rf ~/projects/meiduo_project/fdfs/storage/data
tar -zxvf ~/projects/meiduo_project/others/data.tar.gz -C ~/projects/meiduo_project/fdfs/storage


echo '安装分词搜索库'
docker image pull delron/elasticsearch-ik:2.4.6-1.0
rm -rf ~/projects/meiduo_project/elasticsearch-2.4.6
cp -r ~/projects/meiduo_project/others/elasticsearch-2.4.6 ~/projects/meiduo_project/elasticsearch-2.4.6
docker run -dti --name=elasticsearch --network=host -v ~/projects/meiduo_project/elasticsearch-2.4.6/config:/usr/share/elasticsearch/config delron/elasticsearch-ik:2.4.6-1.0


echo '启动后台服务'
echo '安装后台环境'
conda env remove --name mall
conda create -n mall python=3 -y
conda activate mall

pip install django==3.2.0
pip install pymysql
pip install django-rest-framework
pip install django-ckeditor
pip install django-crontab
pip install django-haystack
pip install django-cors-headers
pip install itsdangerous==1.1.0
pip install Pillow
pip install djangorestframework-jwt
pip install django-redis
 pip install drf-haystack

pip install jinja2
pip install elasticsearch
pip install celery


cd ~/projects/meiduo_project/meiduo_mall
celery -A celery_tasks.main worker -l info