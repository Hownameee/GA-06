import { useForm } from "react-hook-form";
import { string, z } from "zod";
import { zodResolver } from "@hookform/resolvers/zod";
import { useContext } from "react";
import ApiContext from "./ApiContext";
import { useNavigate } from "react-router-dom";

export default function Activate() {
  // Load API url and key from context
  const api = useContext(ApiContext);
  const navigate = useNavigate();

  // Zod schema for validation
  const schema = z.object({
    otp: z
      .string()
      .length(6, { message: "OTP must be exactly 6 digits" }) // lenght 6
      .regex(/^\d+$/, { message: "OTP must contain only numbers" }),
  });

  const {
    register,
    handleSubmit,
    formState: { errors },
  } = useForm({
    resolver: zodResolver(schema),
  });

  const onSubmit = (data) => {
    // Submit data to API
    fetch(`${api.url}/auth/activate`, {
      // Must use POST to submit data
      method: "POST",
      headers: {
        Authorization: `Bearer ${api.key}`,
        // Must be JSON
        "Content-Type": "application/json",
      },
      // Create JSON from object
      body: JSON.stringify({
        otp: data.otp,
      }),
    }).then(async (result) => {
      // 201 => Created
      if (result.status === 200) {
        const json = await result.json();
        console.log("Activate successfully!", json);
        // For current load
        api.setKey(json.token);
        // For next page load
        localStorage.setItem("token", json.token);
        navigate("/me", { replace: true });
      } else {
        alert("Something went wrong! Check the console!");
        console.error(result);
      }
    });
  };

  return (
    <form
      onSubmit={handleSubmit(onSubmit)}
      className="max-w-md mx-auto p-4 bg-white shadow-md rounded-md space-y-6"
    >
      {/* Email */}
      <div>
        <label className="block mb-1 font-semibold" htmlFor="email">
          OTP code
        </label>
        <input
          id="recipient"
          type="text"
          {...register("otp")}
          className={`w-full px-3 py-2 border rounded ${
            errors.email ? "border-red-500" : "border-gray-300"
          }`}
        />
        {errors.email && (
          <p className="text-red-500 text-sm mt-1">{errors.email.message}</p>
        )}
      </div>

      <button
        type="submit"
        className="w-full bg-blue-600 text-white py-2 rounded hover:bg-blue-700 transition"
      >
        Active
      </button>
    </form>
  );
}
