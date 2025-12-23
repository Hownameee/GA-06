import dotenv from "dotenv";
import nodemailer from "nodemailer";

dotenv.config();

const transporter = nodemailer.createTransport({
  host: "smtp.gmail.com",
  port: 587,
  secure: false,
  auth: {
    user: process.env.EMAIL,
    pass: process.env.PASSWORD,
  },
});

const service = {
  send: async function (to, subject, text) {
    return transporter.sendMail({
      from: "Authentication from ThinkLab",
      to: to,
      subject: subject,
      text: text,
    });
  },
};

export default service;
