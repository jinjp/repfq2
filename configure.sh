echo debug01
mkdir /tmp/v2ray
wget -q https://github.com/v2fly/v2ray-core/releases/latest/download/v2ray-linux-64.zip -O /tmp/v2ray/v2ray.zip
unzip /tmp/v2ray/v2ray.zip -d /tmp/v2ray
echo debug02
install -m 755 /tmp/v2ray/v2ray /usr/local/bin/v2ray
install -m 755 /tmp/v2ray/v2ctl /usr/local/bin/v2ctl
echo debug03

# Remove temporary directory
rm -rf /tmp/v2ray

# V2Ray new configuration
install -d /usr/local/etc/v2ray
echo debug05
cat << EOF > /usr/local/etc/v2ray/config.json
{
    "inbounds": [
        {
            "port": $PORT,
            "protocol": "vmess",
            "settings": {
                "clients": [
                    {       
                        "id": "$UUID",
                        "alterId": 64
                    }       
                ],          
                "disableInsecureEncryption": true
            },              
            "streamSettings": {
                "network": "ws"
            }               
        }                   
    ],                      
    "outbounds": [          
        {                   
            "protocol": "freedom"
        }                   
    ]                       
}  
EOF
                      
echo debug06

# Run V2Ray                  
/usr/local/bin/v2ray -config /usr/local/etc/v2ray/config.json
echo debug07
