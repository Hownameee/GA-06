import service from "../services/user.js";
import authService from "../services/auth.js";

export default async function otpValidation(req, res, next) {
  const { email } = req.body;
  const found = await service.findByEmail(email);
  if (!found) {
    return res.status(401).json({
      message: "Email/Password invalid",
    });
  }
  if (!found.isActivte) {
    console.log("Unactive come", found.email);
    const token = await authService.generateToken({ email: found.email });
    return res.status(409).json({token});
  }
  req.found = found;
  next();
}
