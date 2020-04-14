##cd /opt/jenkins/workspace/PROD-ddc_app
pwd
npm i
npm run build:dll
npm run build
cp -f app/.htaccess.prod build/.htaccess



##########################
### BUILDING ddc_app_build
##########################
cd ../ddc_app_build
git checkout master
git pull --no-ff --no-edit origin master

#rm -rf backup && mkdir .backup && mv * .backup/ && mv .backup backup
#cp .htaccess* backup/
rm -rf *

cp -r $WORKSPACE/build/* ./
git add .
git commit --author="$GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>" -m "$BUILD_TAG \n $BUILD_URL"
git push -u origin master

##########################
### COPY INTO APP_PROD01
##########################
scp -r * .htaccess natan@172.16.1.0:~/ddc_app_build/



##########################
### SSH natan@172.16.1.0:22
##########################
cd /var/www/vhosts/dusdusan.com/
tar --exclude='**/.git/*' -czvf public_html_$(date +%d%m%y).tar.gz public_html/

#cd /var/www/vhosts/dusdusan.com/public_html/
#sudo git pull --no-ff --no-edit origin master

sudo rm -rf /var/www/vhosts/dusdusan.com/public_html/*
sudo cp -r ~/ddc_app_build/* /var/www/vhosts/dusdusan.com/public_html/*
sudo cp ~/ddc_app_build/.htaccess /var/www/vhosts/dusdusan.com/public_html/
rm -rf ~/ddc_app_build/*
