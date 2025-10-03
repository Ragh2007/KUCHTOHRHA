const express = require("express");
const http = require("http");
const { Server } = require("socket.io");

const app = express();
const server = http.createServer(app);

const io = new Server(server, {
  cors: {
    origin: "*",  
    methods: ["GET", "POST"]
  }
});

io.on("connection", (socket) => {
  console.log("A user connected:", socket.id);


  socket.on("callUser", (data) => {
    console.log("Call request:", data);
    io.to(data.userToCall).emit("callMade", {
      from: data.from,
      signal: data.signal
    });
  });

  socket.on("answerCall", (data) => {
    console.log("Answer received:", data);
    io.to(data.to).emit("answerMade", data.signal);
  });


  socket.on("disconnect", () => {
    console.log("User disconnected:", socket.id);
  });
});

server.listen(3000, "0.0.0.0", () => {
  console.log("Signalling server running on ws://0.0.0.0:3000");
});
