########################################
##  _           _  _     _            ##
## | |__  _  _ (_)| | __| | ___  _ _  ##
## | '_ \| || || || |/ _` |/ -_)| '_| ##
## |_.__/ \_,_||_||_|\__,_|\___||_|   ##
########################################

# base image
FROM node:20.9.0 as builder
# set working directory
RUN mkdir /usr/src/app
WORKDIR /usr/src/app

# add `/usr/src/app/node_modules/.bin` to $PATH
ENV PATH /usr/src/app/node_modules/.bin:$PATH

# install and cache app dependencies
COPY package.json /usr/src/app/package.json
RUN npm install
RUN npm install -g @angular/cli@17.0.0

# add app
COPY . /usr/src/app

#generate build
RUN npm run build 

############################
##                     _  ##
##  _ __  _ _  ___  __| | ##
## | '_ \| '_|/ _ \/ _` | ##
## | .__/|_|  \___/\__,_| ##
## |_|                    ##
############################
# base image
FROM nginx:1.24.0-alpine

# copy artifact build from the 'build environment'
COPY --from=builder  /usr/src/app/dist /usr/share/nginx/html
COPY default.conf /etc/nginx/conf.d/default.conf

# expose port 80
EXPOSE 80

# run nginx
CMD ["nginx", "-g", "daemon off;"]