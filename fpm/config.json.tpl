{
    "system": {
        "trusted_proxies": [
            TRUSTED_PROXIES
        ],
        "trusted_domains": [
            TRUSTED_DOMAINS
        ],
        "allow_local_remote_servers": true,
        "overwrite.cli.url": "PROTOCOL_PREFIX:\/\/NEXTCLOUD_DOMAIN",
        "overwritehost": "NEXTCLOUD_DOMAIN",
        "overwriteprotocol": "https",
        "lost_password_link": "\/lost_password.html",
    },
    "apps": {
        "files_external": {
            "allow_user_mounting": "no",
            "enabled": "yes",
        },
        "onlyoffice": {
            "DocumentServerInternalUrl": "http:\/\/onlyoffice\/",
            "DocumentServerUrl": "PROTOCOL_PREFIX:\/\/ONLYOFFICE_DOMAIN\/",
            "StorageUrl": "PROTOCOL_PREFIX:\/\/NEXTCLOUD_DOMAIN\/",
            "defFormats": "{\"csv\":\"false\",\"doc\":\"true\",\"docm\":\"false\",\"docx\":\"true\",\"dotx\":\"false\",\"epub\":\"false\",\"html\":\"false\",\"odp\":\"true\",\"ods\":\"true\",\"odt\":\"true\",\"pdf\":\"false\",\"potm\":\"false\",\"potx\":\"false\",\"ppsm\":\"false\",\"ppsx\":\"false\",\"ppt\":\"true\",\"pptm\":\"false\",\"pptx\":\"true\",\"rtf\":\"false\",\"txt\":\"false\",\"xls\":\"true\",\"xlsm\":\"false\",\"xlsx\":\"true\",\"xltm\":\"false\",\"xltx\":\"false\"}",
            "editFormats": "{\"csv\":\"true\",\"odp\":\"true\",\"ods\":\"true\",\"odt\":\"true\",\"rtf\":\"false\",\"txt\":\"true\"}",
            "enabled": "yes",
            "sameTab": "false",
        },
        "user_ldap": {
            "enabled": "yes",
            "s01home_folder_naming_rule": "attr:cn",
            "s01ldap_base": "dc=SLAPD_DOMAIN1,dc=SLAPD_DOMAIN0",
            "s01ldap_base_groups": "dc=SLAPD_DOMAIN1,dc=SLAPD_DOMAIN0",
            "s01ldap_base_users": "dc=SLAPD_DOMAIN1,dc=SLAPD_DOMAIN0",
            "s01ldap_configuration_active": "1",
            "s01ldap_display_name": "cn",
            "s01ldap_email_attr": "Email",
            "s01ldap_expert_username_attr": "cn",
            "s01ldap_ext_storage_home_attribute": "cn",
            "s01ldap_gid_number": "gidNumber",
            "s01ldap_group_display_name": "cn",
            "s01ldap_group_filter": "(|(cn=students)(cn=teachers))",
            "s01ldap_group_member_assoc_attribute": "memberUid",
            "s01ldap_host": "LDAP_HOST",
            "s01ldap_login_filter": "(&(|(objectclass=inetOrgPerson))(uid=%uid))",
            "s01ldap_port": "389",
            "s01ldap_tls": "0",
            "s01ldap_userfilter_objectclass": "inetOrgPerson",
            "s01ldap_userlist_filter": "(|(objectclass=inetOrgPerson))",
            "s01use_memberof_to_detect_membership": "1",
            "types": "authentication"
        },
    }
}
