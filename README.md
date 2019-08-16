# jupyter-lab-server
Hi!  
This is my personal environment for playing with kaggle using jupyter-lab and anaconda.  
Disclamer: tested on the Ubuntu Server 18.04.  
## Requirements
To set-up everything you need execute the following step:  
1. Create projects directory: '/home/<your_username>/projects'
2. Download your kaggle API token - [instruction here](https://github.com/Kaggle/kaggle-api)
3. Extract `kaggle.json` to '/home/<your_username>/.kaggle' directory and change permisions using
   `chmod 600 ~/.kaggle/kaggle.json`
## Start the container
To start run `docker-compose up -d` in the repo directory.

## Stop the container
To stop run `docker-compose down` in the repo directory.
