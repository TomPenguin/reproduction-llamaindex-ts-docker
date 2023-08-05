import { Document, VectorStoreIndex } from "llamaindex";

const main = async () => {
  const document = new Document({ text: "TomPenguin lives in Japan." });

  const index = await VectorStoreIndex.fromDocuments([document]);

  const queryEngine = index.asQueryEngine();
  const response = await queryEngine.query("Where does TomPenguin live?");

  console.log(response.toString());
};

main();
