import React from "react";
import { Link } from "react-router-dom";
import axios from "axios";
import { useNavigate } from "react-router-dom";
import "./verify.css";
import { useForm } from "react-hook-form";
import "animate.css/animate.min.css";
import "react-toastify/dist/ReactToastify.css";
import { ToastContainer, toast, cssTransition } from "react-toastify";

const bounce = cssTransition({
  enter: "animate__animated animate__bounceIn",
  exit: "animate__animated animate__bounceOut",
});

function Verify() {
  const {
    register,
    handleSubmit,
    formState: { errors },
    reset,
  } = useForm({});
  const navigate = useNavigate();

  const storage = localStorage.getItem("user");

  const submit = (data) => {
    console.log(typeof storage);
    console.log(data);
    axios
      .post(
        "https://tech-driven-trade-by-barter-backend.onrender.com/api/v1/auth/verify-email/" +
          storage,
        data
      )
      //   .then((res) => {
      //     console.log(res.data);
      //     navigate("/login");
      //   })
      //   .catch((err) => {
      //     console.log(err);
      //   });
      // axios
      //   .post(
      //     `https://tech-driven-trade-by-barter-backend.onrender.com/api/v1/auth/verify-email/${storage}`,
      //     data,
      //     {
      //       headers: {
      //         "content-type": "application/json",
      //       },
      //     }
      //   )

      .then((response) => {
        console.log(response.data);
        // localStorage.setItem(
        //   "user",
        //   JSON.stringify({
        //     isLoggedIn: false,
        //     token: "",
        //     userId: response.data.userId,
        //   })
        // );
        localStorage.setItem("userId", response.data.userId);
        // navigate("/login");
        setTimeout(() => navigate("/login"), 2000);
        toast.success(response.data.msg, {
          transition: bounce,
          // hideProgressBar,
        });
      })
      .catch((error) => {
        // console.log(error);
        toast.success(error.response.data.msg, {
          transition: bounce,
          // hideProgressBar,
        });
      });
    reset();
  };

  return (
    <div className="vercon">
      {/* <div className="vercon2"> */}
      <h1>Kindly verify the email sent to you</h1>
      <br />
      <form onSubmit={handleSubmit(submit)}>
        <div className="verifyCon">
          <input
            type="text"
            name="number"
            placeholder="input token"
            {...register("verificationToken", {
              required: true,
              // pattern: /^(?=.\d)(?=.[a-z])(?=.*[A-Z]).{6,15}$/,
            })}
          />

          <p className="errormessage">
            {errors.number?.type === "required" &&
              "Please enter the correct token sent to your email"}
          </p>
        </div>
        <div className="verifyBtn">
          {/* <Link to={"/login"}> */}
          <button>Submit</button>
          {/* </Link> */}
        </div>
      </form>
      <ToastContainer transition={bounce} />
    </div>
    // </div>
  );
}

export default Verify;
