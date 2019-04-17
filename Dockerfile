# build phase, this file is for production. 
#This is multistep build with 2 blocks

FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .

RUN npm run build

# is the directory we need to copy /app/build, this is block 2 of the build
# from build one copy the build directory to build 2 and run nginx.

FROM nginx
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html