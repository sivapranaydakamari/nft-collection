# 1. Use Node.js LTS base image
FROM node:18-alpine

# 2. Set working directory inside container
WORKDIR /app

# 3. Copy package files and install dependencies
COPY package*.json ./
RUN npm install

# 4. Copy the entire project
COPY . .

# 5. Compile contracts
RUN npx hardhat compile

# 6. Default command runs the test suite
CMD ["npx", "hardhat", "test", "--show-stack-traces"]
