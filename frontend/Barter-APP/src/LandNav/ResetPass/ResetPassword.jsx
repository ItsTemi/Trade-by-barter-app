import React from "react";

import { useForm } from "react-hook-form";
import { Link } from "react-router-dom";
import { useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";
import "./resetPassword.css";
import axios from "axios";
import "animate.css/animate.min.css";
import "react-toastify/dist/ReactToastify.css";
import { ToastContainer, toast, cssTransition } from "react-toastify";

const bounce = cssTransition({
  enter: "animate__animated animate__bounceIn",
  exit: "animate__animated animate__bounceOut",
});

const url = "";

function ResetPassword() {
  const [submitingForm, setSubmitingForm] = useState(false);
  const {
    register,
    handleSubmit,
    watch,
    formState: { errors },
    reset,
  } = useForm({});
  const navigate = useNavigate();

  //   const storage = localStorage.getItem("user");

  const submit = (data, e) => {
    console.log("###");
    e.preventDefault();
    setSubmitingForm(true);
    axios
      .post(
        "https://tech-driven-trade-by-barter-backend.onrender.com/api/v1/auth/reset-password",
        //   storage,
        data
      )
      .then((response) => {
        console.log(response.data);

        // navigate("/login");
        setTimeout(() => navigate("/login"), 3000);
        toast.success(response.data.msg, {
          transition: bounce,
          //   hideProgressBar,
        });
      })
      .catch((error) => {
        // console.log(error);
        toast.error(error.response.data.msg, {
          transition: bounce,
          //   hideProgressBar,
        });
      });
    reset();
  };

  return (
    <div className="reset-container">
      <h1>Follow the steps bellow to reset your Password</h1>
      <div className="">
        {submitingForm && <p className="pleasewait"> Please wait...</p>}
        <div>
          <form className="resetform" onSubmit={handleSubmit(submit)}>
            <input
              type="email"
              placeholder="Email Address"
              name="email"
              className="details-input"
              {...register("email", {
                required: true,
                // pattern:
                //   /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/,
              })}
            />

            <p className="errormessage">
              {errors.email?.type === "required" &&
                "please enter an email address"}
            </p>
            <p className="errormessage">
              {errors.email?.type === "pattern" && "your email is not valid"}
            </p>

            <input
              type="text"
              placeholder="input token"
              name="token"
              className="details-input"
              {...register("token", { required: true, maxlength: 30 })}
            />
            <p className="errormessage">
              {errors.username?.type === "required" && "Last name is required"}
            </p>
            <p className="errormessage">
              {errors.username?.type === "maxLength" &&
                "your username should not be more than 14 character long"}
            </p>

            <input
              type="password"
              placeholder="Reset Password"
              name="password"
              className="details-input"
              {...register("password", {
                required: true,
                // pattern: /^(?=.\d)(?=.[a-z])(?=.*[A-Z]).{6,15}$/,
              })}
            />
            <p className="errormessage">
              {errors.password?.type === "required" &&
                "Please enter a password"}
            </p>
            <p className="errormessage">
              {errors.password?.type === "pattern" &&
                "Password must contain letters,Uppercase, Numbers, special character and should not be less than 6 and more than 15 characters"}
            </p>
            <input
              type="password"
              placeholder="Confirm Password"
              name="confirmPassword"
              className="details-input"
              {...register("confirmPassword", {
                required: true,
                validate: (value) => {
                  if (watch("password") != value) {
                    return "Your passwords do no match";
                  }
                },
              })}
            />
            <p className="errormessage">
              {errors.confirmPassword?.type === "validate" &&
                "Password does not match"}
            </p>

            <div className="option"></div>

            <div className="regetpass-button">
              <button type="submit">Submit</button>
            </div>

            <br />
          </form>
        </div>
      </div>
      <ToastContainer transition={bounce} />
    </div>
  );
}

export default ResetPassword;
