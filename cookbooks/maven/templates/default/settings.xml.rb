<?xml version="1.0" encoding="UTF-8"?>
<settings xmlns="http://maven.apache.org/SETTINGS/1.0.0"
          xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
          xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.0.0 http://maven.apache.org/xsd/settings-1.0.0.xsd">
 
  <proxies>   
    <proxy>
      <id>corp-prox</id>
      <active>true</active>
      <protocol>http</protocol>   
      <host><%= @proxy_host %></host>
      <port><%= @proxy_port %></port>
      <nonProxyHosts><%= @proxy_exclude %></nonProxyHosts>
    </proxy>    
  </proxies>
</settings>
