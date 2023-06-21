# Penlab

Script pour la création automatique de containeur du module **VIR2**

## Arborescence

<code>
root@pve1:~/penlab# tree -a
.
├── .ansible
│   ├── inventory
│   │   ├── pentester.cfg
│   │   └── pirate.cfg
│   └── playbook
│       ├── pentester.yml
│       └── pirate.yml
├── basic_setup.sh
├── .container
│   ├── CT
│   │   ├── ip
│   │   ├── list
│   │   └── name
│   └── TPL
│       ├── pentester
│       │   └── ip
│       └── pirate
│           └── ip
├── create_ct.sh
├── create_pentester-TPL.sh
├── create_pirate-TPL.sh
├── get_ct.sh
├── remove_ct.sh
├── shutdown_ct.sh
└── start_ct.sh
</code>
<br>

*Les autres fichiers sont générés automatiquement pour les fichiers de script*

