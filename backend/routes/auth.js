import { Router } from "express";
import authController from "../controllers/auth.js";
import requiredToken from "../middlewares/requiredToken.js";
import otpValidation from "../middlewares/otpValidation.js";

const route = new Router();

// POST: Register
route.post("/register", authController.register);

// POST: Login
route.post("/login", otpValidation, authController.login);

// GET: Get current user
route.get("/me", requiredToken, authController.getCurrentUser);

// POST: Activate user
route.post("/activate", requiredToken, authController.activate);

export default route;
