cp ~/Downloads/samatex.zip s1.dvk.co:~/samatex.zip
ssh s1.dvk.co zip -r vkpbouw-themes-backup.zip /var/www/www.vkpbouw.com/wp-content/themes/
ssh s1.dvk.co unzip samatex.zip -d /var/www/www.vkpbouw.com/wp-content/themes/
ssh s1.dvk.co zip -r vkpbouw-plugins-backup.zip /var/www/www.vkpbouw.com/wp-content/plugins/
ssh s1.dvk.co unzip /var/www/www.vkpbouw.com/wp-content/themes/samatex/plugins/enovathemes-addons.zip -d /var/www/www.vkpbouw.com/wp-content/plugins/
ssh s1.dvk.co unzip /var/www/www.vkpbouw.com/wp-content/themes/samatex/plugins/envato-market.zip -d /var/www/www.vkpbouw.com/wp-content/plugins/  
ssh s1.dvk.co unzip /var/www/www.vkpbouw.com/wp-content/themes/samatex/plugins/js_composer.zip -d /var/www/www.vkpbouw.com/wp-content/plugins/  
ssh s1.dvk.co unzip /var/www/www.vkpbouw.com/wp-content/themes/samatex/plugins/revslider.zip -d /var/www/www.vkpbouw.com/wp-content/plugins/  
ssh s1.dvk.co sudo rm -r /tmp/nginx-cache/


 
