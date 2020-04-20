# ACNH Creature Tracker

[front-end here](https://github.com/robotspacefish/acnh_creature_tracker_frontend)

Keep track of the creatures you catch and hand in to the museum in Animal Crossing: New Horizons as well as see which creatures are currently available to catch. ACNH Creature Tracker was built using React, Redux, and Rails

## Installation

Clone and run:

```
bundle install

# setup the db
rails db:create db:migrate

# To populate creatures in the database, either run:
rails db:seed

# or 

# Enter the Rails console
rails c

# Inside the console, type:
CreatureScraper.scrape
```

## Usage

Download the [front-end](https://github.com/robotspacefish/acnh_creature_tracker_frontend) part of this project and nest both front and back end projects into a parent folder.

```
 acnh_creature_tracker 
 	|_ acnh_frontend
 	|_ acnh_backend
```

Next, follow the instructions in the README in the frontend part of project.

Once everything is installed, open the terminal, navigate to the acnh_backend folder, and type:

```
rake start
```

Alternatively:

```
# you can run the app by navigating into acnh_frontend and typing:
yarn start

# navigate to the acnh_backend folder and type:
rails s -p 3001
```




