import React from "react";
import "./pro.css";
import Nav from "../Nav";
import { useForm } from "react-hook-form";
import { useState, useEffect, useRef } from "react";
import axios from "axios";
import { useNavigate } from "react-router-dom";
import { useContext } from "react";
// import { AccessProvider } from "react";
import { AccessProv } from "../ContextApi/Context";

const url =
  "https://tech-driven-trade-by-barter-backend.onrender.com/api/v1/item/createitem";

function Pro() {
  const [images, setImages] = useState([]);
  const { access } = useContext(AccessProv);
  const navigate = useNavigate();
  const inputRef = useRef();

  const {
    register,
    handleSubmit,
    watch,
    formState: { errors },
    reset,
  } = useForm({});

  const submit = (data) => {
    //   console.log(typeof storage);
    // console.log(data);
    axios
      .post(
        url,

        data
      )
      .then((response) => {
        console.log(response.data);

        // localStorage.setItem("user", response.data.userId);
        // navigate("/login");
        setTimeout(() => navigate("/login"), 2000);
        toast.success(response.data.msg, {
          transition: bounce,
          // hideProgressBar,
        });
      })
      .catch((error) => {
        // console.log(error);
        // toast.success(error.response.data.msg, {
        //   transition: bounce,
        // hideProgressBar,
        // });
      });
    reset();
  };

  const handleChange = (e) => {
    const fileUploaded = e.target.files[0];
    var reader = new FileReader();
    reader.onload = function () {
      let currentImages = [];
      if (images.length == 0) {
        currentImages = [reader.result];
      } else {
        currentImages = [reader.result, ...images];
      }
      setImages(currentImages);
      console.log(images);
    };
    reader.readAsDataURL(fileUploaded);
  };

  const inputImage = () => {
    inputRef.current.click();
  };

  return (
    <div>
      <Nav access={access} />
      <div className="profile-main-container">
        <div className="profile-main-page">
          <div className="add-product">
            <div className="add-product2">
              <h1>Add product</h1>
              <br />
              <p>-You can add up to 10 photos!!!</p>
              <p>-Add pictures where your product is in good light</p>
              <p>-Add multiple pictures from different angles</p>
            </div>
          </div>
          <br />
          <br />
          <form onSubmit={handleSubmit(submit)}>
            <div className="profile-pictures">
              <div className="product-cover1">
                {/* <div> */}
                {images.map((i, k) => {
                  return <img src={i} alt="" key={k} />;
                })}
                {/* </div> */}
                {/* <div className="picture-box1"> </div> */}
                <input
                  type="file"
                  accept=".png, .jpg, .jpeg"
                  hidden
                  ref={inputRef}
                  onChange={handleChange}
                />
                <button className="picture-box2" onClick={inputImage}>
                  <div className="picture2Input">
                    <h1>+</h1>
                    <h1>Add photo</h1>
                  </div>
                </button>
              </div>
              {/* <div className=''>
                      <div className='picturePro'>A picture pf the product is required</div>
                </div> */}
            </div>

            <div className="product-name">
              <h3 className="pro1">Product name</h3>
              <input
                type="text"
                name="product"
                className="location-input1"
                {...register("product", {
                  required: true,
                })}
              />
              <h3 className="pro2">
                Mention the key features of your item (e.g brand, model,type
              </h3>
            </div>
            <div className="description">
              <h3 className="des">Description</h3>
              <div className="textarea">
                <textarea
                  name="description"
                  id=""
                  cols="70"
                  rows="10"
                  {...register("description", {
                    required: true,
                  })}
                ></textarea>
              </div>
              <h3 className="des2">
                Mention more features and reason for selling
              </h3>
            </div>
            <div className="location">
              <h3 className="cat">Location</h3>
              <div>
                <input
                  type="text"
                  name="location"
                  className="location-input2"
                  {...register("location", {
                    required: true,
                  })}
                />
              </div>
            </div>
            <div className="pro-condition">
              <button>
                <h3>Production condition</h3>
              </button>
              <div className="production-boxes">
                <div className="production-box1">
                  <button>
                    <h2>Very Old</h2>
                  </button>
                </div>
                <div className="production-box2">
                  <button>
                    <h2>Used</h2>
                  </button>
                </div>
                <div className="production-box3">
                  <button>
                    <h2>Brand New</h2>
                  </button>
                </div>
              </div>
            </div>
            <br />
            <div className="button">
              <div className="button-div">
                <button className="button1">Add product</button>
              </div>
            </div>
          </form>
          <button className="button2">Cancel</button>
        </div>
      </div>
    </div>
  );
}

export default Pro;
