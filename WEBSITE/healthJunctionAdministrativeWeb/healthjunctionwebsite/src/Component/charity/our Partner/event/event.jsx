/* eslint-disable jsx-a11y/img-redundant-alt */

export default function Events() {
  return (
    <div className="flex flex-col min-h-screen">
     <header>
        <h1>
            Events
        </h1>
     </header>
      <main className="flex-1 p-6 bg-white-100">
        <section className="mb-8" id="description">
          <h2 className="mb-2 text-xl font-bold">Description</h2>
          <p className="text-gray-700">
            This is a placeholder description for the event. It will be replaced with the actual event description.
          </p>
        </section>
        <section className="mb-8" id="images">
          <h2 className="mb-2 text-xl font-bold">Images</h2>
          <div className="grid grid-cols-3 gap-4">
            <img
              alt="Event Image 1"
              className="object-cover w-full h-32 rounded-md"
              height="200"
              src="/placeholder.svg"
              style={{
                aspectRatio: "200/200",
                objectFit: "cover",
              }}
              width="200"
            />
            <img
              alt="Event Image 2"
              className="object-cover w-full h-32 rounded-md"
              height="200"
              src="/placeholder.svg"
              style={{
                aspectRatio: "200/200",
                objectFit: "cover",
              }}
              width="200"
            />
            <img
              alt="Event Image 3"
              className="object-cover w-full h-32 rounded-md"
              height="200"
              src="/placeholder.svg"
              style={{
                aspectRatio: "200/200",
                objectFit: "cover",
              }}
              width="200"
            />
          </div>
        </section>
        <section className="mb-8" id="videos">
          <h2 className="mb-2 text-xl font-bold">Videos</h2>
          <div className="grid grid-cols-2 gap-4">
            <img
              alt="Event Video 1"
              className="object-cover w-full h-32 rounded-md"
              height="200"
              src="/placeholder.svg"
              style={{
                aspectRatio: "200/200",
                objectFit: "cover",
              }}
              width="200"
            />
            <img
              alt="Event Video 2"
              className="object-cover w-full h-32 rounded-md"
              height="200"
              src="/placeholder.svg"
              style={{
                aspectRatio: "200/200",
                objectFit: "cover",
              }}
              width="200"
            />
          </div>
        </section>
      </main>
    </div>
  )
}

