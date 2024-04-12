/* eslint-disable jsx-a11y/img-redundant-alt */

export default function Events() {
  return (
    <div className="flex flex-col min-h-screen">
      <header>
        <h1 className="text-3xl font-bold text-center text-purple-700 ">
          Event Highlights
        </h1>
      </header>
      <main className="flex-1 p-6 bg-white-100">
        <section className="mb-8" id="description">
          <p className="text-gray-700">
            Explore impactful moments from various BDS events, including the{" "}
            <b>"Blood Group Testing Drive"</b>, <b>"Rashan Drive"</b>,{" "}
            <b>"Blood Donation Drive"</b> and other charitable initiatives.
            Witness the unwavering commitment and dedication of our community
            towards creating positive change in society.
          </p>
        </section>
        <section className="mb-8" id="images">
          {/* <h2 className="mb-2 text-xl font-bold">Images</h2> */}
          <div className="grid grid-cols-3 gap-4">
            <img
              alt="Event Image 1"
              className="object-cover w-full h-48 rounded-md"
              src="images/Blood donation camp/check.jpg"
              style={{
                aspectRatio: "4/5",
              }}
            />
            <img
              alt="Event Image 2"
              className="object-cover w-full h-48 rounded-md"
              src="images/Blood test stall/123.jpg"
              style={{
                aspectRatio: "4/5",
              }}
            />
            <img
              alt="Event Image 3"
              className="object-cover w-full h-48 rounded-md"
              src="images/Blood test stall/BDSb.jpg"
              style={{
                aspectRatio: "4/5",
              }}
            />
          </div>
        </section>
        <section className="mb-8" id="videos">
          {/* <h2 className="mb-2 text-xl font-bold">Videos</h2> */}
          <div className="grid grid-cols-2 gap-4">
            <video
              controls
              className="object-cover w-full h-48 rounded-md"
              style={{
                aspectRatio: "1/1",
              }}
            >
              <source src="images/bds1.mp4" type="video/mp4" />
              Your browser does not support the video tag.
            </video>
            <video
              controls
              className="object-cover w-full h-48 rounded-md"
              style={{
                aspectRatio: "1/1",
              }}
            >
              <source src="images/bds2.mp4" type="video/mp4" />
              Your browser does not support the video tag.
            </video>
          </div>
        </section>
      </main>
    </div>
  );
}
